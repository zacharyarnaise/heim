import locale
import os
import re
import sys
from datetime import date, datetime, timedelta, timezone
from typing import Any
from zoneinfo import ZoneInfo

import holidays
import requests

Card = dict[str, Any]
Stack = dict[str, Any]


BOARD_ID = 2
DAILY_STACK = 5
SPRINT_STACK = 7
# Aware datetimes shift by wall clock, so this survives DST
SPRINT_LENGTH = timedelta(days=14)
SPRINT_TITLE = re.compile(r"^(\d+):")
TZ = ZoneInfo("Europe/Paris")


class DeckAPI:
    """Simple wrapper around the Nextcloud Deck API.

    See: https://deck.readthedocs.io/en/latest/API/"""
    base_url: str
    user: str
    password: str

    def __init__(self, nextcloud_url: str, user: str, password: str) -> None:
        self.base_url = nextcloud_url.rstrip("/") + "/index.php/apps/deck/api/v1.1"
        self.user = user
        self.password = password

    def _request(self, method: str, path: str, **kwargs: Any) -> requests.Response:
        r = requests.request(
            method,
            self.base_url + path,
            headers={"OCS-APIRequest": "true"},
            auth=(self.user, self.password),
            timeout=10,
            **kwargs,
        )
        r.raise_for_status()
        return r

    def get_stacks(self, board_id: int) -> list[Stack]:
        stacks: list[Stack] = self._request("GET", f"/boards/{board_id}/stacks").json()
        return stacks

    def create_card(self, board_id: int, stack_id: int, card: Card) -> Card:
        created: Card = self._request(
            "POST", f"/boards/{board_id}/stacks/{stack_id}/cards", json=card
        ).json()
        return created

    def dependent_cards(
        self, board_id: int, stack_id: int, card_id: int, dependent_id: int
    ) -> None:
        self._request(
            "POST",
            f"/boards/{board_id}/stacks/{stack_id}/cards/{card_id}/dependentCards/{dependent_id}",
        )


def from_deck_date(value: str | None) -> datetime | None:
    return datetime.fromisoformat(value).astimezone(TZ) if value else None


def latest_sprint(stacks: list[Stack]) -> tuple[int, Card]:
    cards = next((s.get("cards") or [] for s in stacks if s["id"] == SPRINT_STACK), [])
    numbered = [
        (int(match.group(1)), card)
        for card in cards
        if (match := SPRINT_TITLE.match(card["title"]))
    ]
    if not numbered:
        sys.exit(f"No sprint card matching 'N: ...' in stack {SPRINT_STACK}")
    return max(numbered, key=lambda pair: pair[0])


def current_sprint(deck: DeckAPI, today: date) -> Card:
    number, card = latest_sprint(deck.get_stacks(BOARD_ID))

    while (due := from_deck_date(card.get("duedate"))) and due.date() < today:
        start = from_deck_date(card.get("startdate")) or due - SPRINT_LENGTH
        number += 1
        start, due = start + SPRINT_LENGTH, due + SPRINT_LENGTH
        card = deck.create_card(
            BOARD_ID,
            SPRINT_STACK,
            {
                "title": f"{number}: {start:%d/%m} -> {due:%d/%m}",
                "order": 0,
                "type": "plain",
                "startdate": start.astimezone(timezone.utc).isoformat(),
                "duedate": due.astimezone(timezone.utc).isoformat(),
            },
        )
        print(f"Created sprint {number}")

    return card


def main() -> None:
    locale.setlocale(locale.LC_TIME, "fr_FR.UTF-8")
    now = datetime.now(TZ)
    today = now.date()

    if today.weekday() >= 5 or today in holidays.France(years=today.year):
        print("Skipping today")
        sys.exit(0)

    deck = DeckAPI(
        os.environ["NEXTCLOUD_URL"],
        os.environ["NEXTCLOUD_USER"],
        os.environ["NEXTCLOUD_PASS"],
    )

    sprint = current_sprint(deck, today)
    daily = deck.create_card(
        BOARD_ID,
        DAILY_STACK,
        {
            "title": today.strftime("%a %d/%m"),
            "order": 0,
            "type": "plain",
            "description": "- [ ] 👋 ",
            "startdate": now.replace(hour=8, minute=0, second=0, microsecond=0)
            .astimezone(timezone.utc)
            .isoformat(),
        },
    )
    deck.dependent_cards(BOARD_ID, SPRINT_STACK, sprint["id"], daily["id"])
    print(f"Created card {daily['id']} under sprint {sprint['title']}")


if __name__ == "__main__":
    main()
