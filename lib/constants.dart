import 'package:flutter/material.dart';

// const kPrimaryColor = Color(0xFF72CBDC);
const kPrimaryColor = Color(0xFF75A9FA);
// const kSecondaryColor = Color(0xFF281EA5);
// const kContentColorLightTheme = Color(0xFF1D1D35);
// const kSecondaryColor = Color(0xFF17172A);
const kSecondaryColor = Color(0xFF1E1E21);
const kContentColorLightTheme = Color(0xFF000000);
const kContentColorDarkTheme = Color(0xFFD8E4EC);
const kWarninngColor = Color(0xFFC7C000);
const kErrorColor = Color(0xFFF03738);
const kGradient1 = Color(0xFF5897FA);
const kGradient2 = Color(0xFFA48BFF);

const kDefaultPadding = 20.0;

List emojiList = [
  "😀",
  "😃",
  "😄",
  "😁",
  "😆",
  "😅",
  "😂",
  "🤣",
  "🥲",
  "☺",
  "😊",
  "😇",
  "🙂",
  "🙃",
  "😉",
  "😌",
  "😍",
  "🥰",
  "😘",
  "😗",
  "😙",
  "😚",
  "😋",
  "😛",
  "😝",
  "😜",
  "🤪",
  "🤨",
  "🧐",
  "🤓",
  "😎",
  "🥸",
  "🤩",
  "🥳",
  "😏",
  "😒",
  "😞",
  "😔",
  "😟",
  "😕",
  "🙁",
  "☹",
  "😣",
  "😖",
  "😫",
  "😩",
  "🥺",
  "😢",
  "😭",
  "😤",
  "😠",
  "😡",
  "🤬",
  "🤯",
  "😳",
  "🥵",
  "🥶",
  "😱",
  "😨",
  "😰",
  "😥",
  "😓",
  "🤗",
  "🤔",
  "🤭",
  "🤫",
  "🤥",
  "😶",
  "😐",
  "😑",
  "😬",
  "🙄",
  "😯",
  "😦",
  "😧",
  "😮",
  "😲",
  "🥱",
  "😴",
  "🤤",
  "😪",
  "😵",
  "🤐",
  "🥴",
  "🤢",
  "🤮",
  "🤧",
  "😷",
  "🤒",
  "🤕",
  "🤑",
  "🤠",
  "😈",
  "👿",
  "👹",
  "👺",
  "🤡",
  "💩",
  "👻",
  "💀",
  "☠",
  "👽",
  "👾",
  "🤖",
  "🎃",
  "😺",
  "😸",
  "😹",
  "😻",
  "😼",
  "😽",
  "🙀",
  "😿",
  "😾",
  "👋",
  "🤚",
  "🖐",
  "✋",
  "🖖",
  "👌",
  "🤌",
  "🤏",
  "✌",
  "🤞",
  "🤟",
  "🤘",
  "🤙",
  "👈",
  "👉",
  "👆",
  "🖕",
  "👇",
  "☝",
  "👍",
  "👎",
  "✊",
  "👊",
  "🤛",
  "🤜",
  "👏",
  "🙌",
  "👐",
  "🤲",
  "🤝",
  "🙏",
  "✍",
  "💅",
  "🤳",
  "💪",
  "🦾",
  "🦵",
  "🦿",
  "🦶",
  "👣",
  "👂",
  "🦻",
  "👃",
  "🫀",
  "🫁",
  "🧠",
  "🦷",
  "🦴",
  "👀",
  "👁",
  "👅",
  "👄",
  "💋",
  "🩸",
  "🐶",
  "🐱",
  "🐭",
  "🐹",
  "🐰",
  "🦊",
  "🐻",
  "🐼",
  "🐻‍❄",
  "🐨",
  "🐯",
  "🦁",
  "🐮",
  "🐷",
  "🐽",
  "🐸",
  "🐵",
  "🙈",
  "🙉",
  "🙊",
  "🐒",
  "🐔",
  "🐧",
  "🐦",
  "🐤",
  "🐣",
  "🐥",
  "🦆",
  "🦅",
  "🦉",
  "🦇",
  "🐺",
  "🐗",
  "🐴",
  "🦄",
  "🐝",
  "🪱",
  "🐛",
  "🦋",
  "🐌",
  "🐞",
  "🐜",
  "🪰",
  "🪲",
  "🪳",
  "🦟",
  "🦗",
  "🕷",
  "🕸",
  "🦂",
  "🐢",
  "🐍",
  "🦎",
  "🦖",
  "🦕",
  "🐙",
  "🦑",
  "🦐",
  "🦞",
  "🦀",
  "🐡",
  "🐠",
  "🐟",
  "🐬",
  "🐳",
  "🐋",
  "🦈",
  "🐊",
  "🐅",
  "🐆",
  "🦓",
  "🦍",
  "🦧",
  "🦣",
  "🐘",
  "🦛",
  "🦏",
  "🐪",
  "🐫",
  "🦒",
  "🦘",
  "🦬",
  "🐃",
  "🐂",
  "🐄",
  "🐎",
  "🐖",
  "🐏",
  "🐑",
  "🦙",
  "🐐",
  "🦌",
  "🐕",
  "🐩",
  "🦮",
  "🐕‍🦺",
  "🐈",
  "🐈‍⬛",
  "🪶",
  "🐓",
  "🦃",
  "🦤",
  "🦚",
  "🦜",
  "🦢",
  "🦩",
  "🕊",
  "🐇",
  "🦝",
  "🦨",
  "🦡",
  "🦫",
  "🦦",
  "🦥",
  "🐁",
  "🐀",
  "🐿",
  "🦔",
  "🐾",
  "🐉",
  "🐲",
  "🌵",
  "🎄",
  "🌲",
  "🌳",
  "🌴",
  "🪵",
  "🌱",
  "🌿",
  "☘",
  "🍀",
  "🎍",
  "🪴",
  "🎋",
  "🍃",
  "🍂",
  "🍁",
  "🍄",
  "🐚",
  "🪨",
  "🌾",
  "💐",
  "🌷",
  "🌹",
  "🥀",
  "🌺",
  "🌸",
  "🌼",
  "🌻",
  "🌞",
  "🌝",
  "🌛",
  "🌜",
  "🌚",
  "🌕",
  "🌖",
  "🌗",
  "🌘",
  "🌑",
  "🌒",
  "🌓",
  "🌔",
  "🌙",
  "🌎",
  "🌍",
  "🌏",
  "🪐",
  "💫",
  "⭐",
  "🌟",
  "✨",
  "⚡",
  "☄",
  "💥",
  "🔥",
  "🌪",
  "🌈",
  "☀",
  "🌤",
  "⛅",
  "🌥",
  "☁",
  "🌦",
  "🌧",
  "⛈",
  "🌩",
  "🌨",
  "❄",
  "☃",
  "⛄",
  "🌬",
  "💨",
  "💧",
  "💦",
  "☔",
  "☂",
  "🌊",
  "🌫",
  "🍏",
  "🍎",
  "🍐",
  "🍊",
  "🍋",
  "🍌",
  "🍉",
  "🍇",
  "🍓",
  "🫐",
  "🍈",
  "🍒",
  "🍑",
  "🥭",
  "🍍",
  "🥥",
  "🥝",
  "🍅",
  "🍆",
  "🥑",
  "🥦",
  "🥬",
  "🥒",
  "🌶",
  "🫑",
  "🌽",
  "🥕",
  "🫒",
  "🧄",
  "🧅",
  "🥔",
  "🍠",
  "🥐",
  "🥯",
  "🍞",
  "🥖",
  "🥨",
  "🧀",
  "🥚",
  "🍳",
  "🧈",
  "🥞",
  "🧇",
  "🥓",
  "🥩",
  "🍗",
  "🍖",
  "🦴",
  "🌭",
  "🍔",
  "🍟",
  "🍕",
  "🫓",
  "🥪",
  "🥙",
  "🧆",
  "🌮",
  "🌯",
  "🫔",
  "🥗",
  "🥘",
  "🫕",
  "🥫",
  "🍝",
  "🍜",
  "🍲",
  "🍛",
  "🍣",
  "🍱",
  "🥟",
  "🦪",
  "🍤",
  "🍙",
  "🍚",
  "🍘",
  "🍥",
  "🥠",
  "🥮",
  "🍢",
  "🍡",
  "🍧",
  "🍨",
  "🍦",
  "🥧",
  "🧁",
  "🍰",
  "🎂",
  "🍮",
  "🍭",
  "🍬",
  "🍫",
  "🍿",
  "🍩",
  "🍪",
  "🌰",
  "🥜",
  "🍯",
  "🥛",
  "🍼",
  "🫖",
  "☕",
  "🍵",
  "🧃",
  "🥤",
  "🧋",
  "🍶",
  "🍺",
  "🍻",
  "🥂",
  "🍷",
  "🥃",
  "🍸",
  "🍹",
  "🧉",
  "🍾",
  "🧊",
  "🥄",
  "🍴",
  "🍽",
  "🥣",
  "🥡",
  "🥢",
  "🧂",
  "⚽",
  "🏀",
  "🏈",
  "⚾",
  "🥎",
  "🎾",
  "🏐",
  "🏉",
  "🥏",
  "🎱",
  "🪀",
  "🏓",
  "🏸",
  "🏒",
  "🏑",
  "🥍",
  "🏏",
  "🪃",
  "🥅",
  "⛳",
  "🪁",
  "🏹",
  "🎣",
  "🤿",
  "🥊",
  "🥋",
  "🎽",
  "🛹",
  "🛼",
  "🛷",
  "⛸",
  "🥌",
  "🎿",
  "⛷",
  "🏂",
  "🪂",
  "🏋‍♀",
  "🏋",
  "🏋‍♂",
  "🤼‍♀",
  "🤼",
  "🤼‍♂",
  "🤸‍♀",
  "🤸",
  "🤸‍♂",
  "⛹‍♀",
  "⛹",
  "⛹‍♂",
  "🤺",
  "🤾‍♀",
  "🤾",
  "🤾‍♂",
  "🏌‍♀",
  "🏌",
  "🏌‍♂",
  "🏇",
  "🧘‍♀",
  "🧘",
  "🧘‍♂",
  "🏄‍♀",
  "🏄",
  "🏄‍♂",
  "🏊‍♀",
  "🏊",
  "🏊‍♂",
  "🤽‍♀",
  "🤽",
  "🤽‍♂",
  "🚣‍♀",
  "🚣",
  "🚣‍♂",
  "🧗‍♀",
  "🧗",
  "🧗‍♂",
  "🚵‍♀",
  "🚵",
  "🚵‍♂",
  "🚴‍♀",
  "🚴",
  "🚴‍♂",
  "🏆",
  "🥇",
  "🥈",
  "🥉",
  "🏅",
  "🎖",
  "🏵",
  "🎗",
  "🎫",
  "🎟",
  "🎪",
  "🤹",
  "🤹‍♂",
  "🤹‍♀",
  "🎭",
  "🩰",
  "🎨",
  "🎬",
  "🎤",
  "🎧",
  "🎼",
  "🎹",
  "🥁",
  "🪘",
  "🎷",
  "🎺",
  "🪗",
  "🎸",
  "🪕",
  "🎻",
  "🎲",
  "♟",
  "🎯",
  "🎳",
  "🎮",
  "🎰",
  "🧩",
  "🚗",
  "🚕",
  "🚙",
  "🚌",
  "🚎",
  "🏎",
  "🚓",
  "🚑",
  "🚒",
  "🚐",
  "🛻",
  "🚚",
  "🚛",
  "🚜",
  "🦯",
  "🦽",
  "🦼",
  "🛴",
  "🚲",
  "🛵",
  "🏍",
  "🛺",
  "🚨",
  "🚔",
  "🚍",
  "🚘",
  "🚖",
  "🚡",
  "🚠",
  "🚟",
  "🚃",
  "🚋",
  "🚞",
  "🚝",
  "🚄",
  "🚅",
  "🚈",
  "🚂",
  "🚆",
  "🚇",
  "🚊",
  "🚉",
  "✈",
  "🛫",
  "🛬",
  "🛩",
  "💺",
  "🛰",
  "🚀",
  "🛸",
  "🚁",
  "🛶",
  "⛵",
  "🚤",
  "🛥",
  "🛳",
  "⛴",
  "🚢",
  "⚓",
  "🪝",
  "⛽",
  "🚧",
  "🚦",
  "🚥",
  "🚏",
  "🗺",
  "🗿",
  "🗽",
  "🗼",
  "🏰",
  "🏯",
  "🏟",
  "🎡",
  "🎢",
  "🎠",
  "⛲",
  "⛱",
  "🏖",
  "🏝",
  "🏜",
  "🌋",
  "⛰",
  "🏔",
  "🗻",
  "🏕",
  "⛺",
  "🛖",
  "🏠",
  "🏡",
  "🏘",
  "🏚",
  "🏗",
  "🏭",
  "🏢",
  "🏬",
  "🏣",
  "🏤",
  "🏥",
  "🏦",
  "🏨",
  "🏪",
  "🏫",
  "🏩",
  "💒",
  "🏛",
  "⛪",
  "🕌",
  "🕍",
  "🛕",
  "🕋",
  "⛩",
  "🛤",
  "🛣",
  "🗾",
  "🎑",
  "🏞",
  "🌅",
  "🌄",
  "🌠",
  "🎇",
  "🎆",
  "🌇",
  "🌆",
  "🏙",
  "🌃",
  "🌌",
  "🌉",
  "🌁",
  "⌚",
  "📱",
  "📲",
  "💻",
  "⌨",
  "🖥",
  "🖨",
  "🖱",
  "🖲",
  "🕹",
  "🗜",
  "💽",
  "💾",
  "💿",
  "📀",
  "📼",
  "📷",
  "📸",
  "📹",
  "🎥",
  "📽",
  "🎞",
  "📞",
  "☎",
  "📟",
  "📠",
  "📺",
  "📻",
  "🎙",
  "🎚",
  "🎛",
  "🧭",
  "⏱",
  "⏲",
  "⏰",
  "🕰",
  "⌛",
  "⏳",
  "📡",
  "🔋",
  "🔌",
  "💡",
  "🔦",
  "🕯",
  "🪔",
  "🧯",
  "🛢",
  "💸",
  "💵",
  "💴",
  "💶",
  "💷",
  "🪙",
  "💰",
  "💳",
  "💎",
  "⚖",
  "🪜",
  "🧰",
  "🪛",
  "🔧",
  "🔨",
  "⚒",
  "🛠",
  "⛏",
  "🪚",
  "🔩",
  "⚙",
  "🪤",
  "🧱",
  "⛓",
  "🧲",
  "🔫",
  "💣",
  "🧨",
  "🪓",
  "🔪",
  "🗡",
  "⚔",
  "🛡",
  "🚬",
  "⚰",
  "🪦",
  "⚱",
  "🏺",
  "🔮",
  "📿",
  "🧿",
  "💈",
  "⚗",
  "🔭",
  "🔬",
  "🕳",
  "🩹",
  "🩺",
  "💊",
  "💉",
  "🩸",
  "🧬",
  "🦠",
  "🧫",
  "🧪",
  "🌡",
  "🧹",
  "🪠",
  "🧺",
  "🧻",
  "🚽",
  "🚰",
  "🚿",
  "🛁",
  "🛀",
  "🧼",
  "🪥",
  "🪒",
  "🧽",
  "🪣",
  "🧴",
  "🛎",
  "🔑",
  "🗝",
  "🚪",
  "🪑",
  "🛋",
  "🛏",
  "🛌",
  "🧸",
  "🪆",
  "🖼",
  "🪞",
  "🪟",
  "🛍",
  "🛒",
  "🎁",
  "🎈",
  "🎏",
  "🎀",
  "🪄",
  "🪅",
  "🎊",
  "🎉",
  "🎎",
  "🏮",
  "🎐",
  "🧧",
  "✉",
  "📩",
  "📨",
  "📧",
  "💌",
  "📥",
  "📤",
  "📦",
  "🏷",
  "🪧",
  "📪",
  "📫",
  "📬",
  "📭",
  "📮",
  "📯",
  "📜",
  "📃",
  "📄",
  "📑",
  "🧾",
  "📊",
  "📈",
  "📉",
  "🗒",
  "🗓",
  "📆",
  "📅",
  "🗑",
  "📇",
  "🗃",
  "🗳",
  "🗄",
  "📋",
  "📁",
  "📂",
  "🗂",
  "🗞",
  "📰",
  "📓",
  "📔",
  "📒",
  "📕",
  "📗",
  "📘",
  "📙",
  "📚",
  "📖",
  "🔖",
  "🧷",
  "🔗",
  "📎",
  "🖇",
  "📐",
  "📏",
  "🧮",
  "📌",
  "📍",
  "✂",
  "🖊",
  "🖋",
  "✒",
  "🖌",
  "🖍",
  "📝",
  "✏",
  "🔍",
  "🔎",
  "🔏",
  "🔐",
  "🔒",
  "🔓",
  "❤",
  "🧡",
  "💛",
  "💚",
  "💙",
  "💜",
  "🖤",
  "🤍",
  "🤎",
  "💔",
  "❣",
  "💕",
  "💞",
  "💓",
  "💗",
  "💖",
  "💘",
  "💝",
  "💟",
  "☮",
  "✝",
  "☪",
  "🕉",
  "☸",
  "✡",
  "🔯",
  "🕎",
  "☯",
  "☦",
  "🛐",
  "⛎",
  "♈",
  "♉",
  "♊",
  "♋",
  "♌",
  "♍",
  "♎",
  "♏",
  "♐",
  "♑",
  "♒",
  "♓",
  "🆔",
  "⚛",
  "🉑",
  "☢",
  "☣",
  "📴",
  "📳",
  "🈶",
  "🈚",
  "🈸",
  "🈺",
  "🈷",
  "✴",
  "🆚",
  "💮",
  "🉐",
  "㊙",
  "㊗",
  "🈴",
  "🈵",
  "🈹",
  "🈲",
  "🅰",
  "🅱",
  "🆎",
  "🆑",
  "🅾",
  "🆘",
  "❌",
  "⭕",
  "🛑",
  "⛔",
  "📛",
  "🚫",
  "💯",
  "💢",
  "♨",
  "🚷",
  "🚯",
  "🚳",
  "🚱",
  "🔞",
  "📵",
  "🚭",
  "❗",
  "❕",
  "❓",
  "❔",
  "‼",
  "⁉",
  "🔅",
  "🔆",
  "〽",
  "⚠",
  "🚸",
  "🔱",
  "⚜",
  "🔰",
  "♻",
  "✅",
  "🈯",
  "💹",
  "❇",
  "✳",
  "❎",
  "🌐",
  "💠",
  "Ⓜ",
  "🌀",
  "💤",
  "🏧",
  "🚾",
  "♿",
  "🅿",
  "🛗",
  "🈳",
  "🈂",
  "🛂",
  "🛃",
  "🛄",
  "🛅",
  "🚹",
  "🚺",
  "🚼",
  "⚧",
  "🚻",
  "🚮",
  "🎦",
  "📶",
  "🈁",
  "🔣",
  "ℹ",
  "🔤",
  "🔡",
  "🔠",
  "🆖",
  "🆗",
  "🆙",
  "🆒",
  "🆕",
  "🆓",
  "0⃣",
  "1⃣",
  "2⃣",
  "3⃣",
  "4⃣",
  "5⃣",
  "6⃣",
  "7⃣",
  "8⃣",
  "9⃣",
  "🔟",
  "🔢",
  "#⃣",
  "*⃣",
  "⏏",
  "▶",
  "⏸",
  "⏯",
  "⏹",
  "⏺",
  "⏭",
  "⏮",
  "⏩",
  "⏪",
  "⏫",
  "⏬",
  "◀",
  "🔼",
  "🔽",
  "➡",
  "⬅",
  "⬆",
  "⬇",
  "↗",
  "↘",
  "↙",
  "↖",
  "↕",
  "↔",
  "↪",
  "↩",
  "⤴",
  "⤵",
  "🔀",
  "🔁",
  "🔂",
  "🔄",
  "🔃",
  "🎵",
  "🎶",
  "➕",
  "➖",
  "➗",
  "✖",
  "♾",
  "💲",
  "💱",
  "™",
  "©",
  "®",
  "〰",
  "➰",
  "➿",
  "🔚",
  "🔙",
  "🔛",
  "🔝",
  "🔜",
  "✔",
  "☑",
  "🔘",
  "🔴",
  "🟠",
  "🟡",
  "🟢",
  "🔵",
  "🟣",
  "⚫",
  "⚪",
  "🟤",
  "🔺",
  "🔻",
  "🔸",
  "🔹",
  "🔶",
  "🔷",
  "🔳",
  "🔲",
  "▪",
  "▫",
  "◾",
  "◽",
  "◼",
  "◻",
  "🟥",
  "🟧",
  "🟨",
  "🟩",
  "🟦",
  "🟪",
  "⬛",
  "⬜",
  "🟫",
  "🔈",
  "🔇",
  "🔉",
  "🔊",
  "🔔",
  "🔕",
  "📣",
  "📢",
  "👁‍🗨",
  "💬",
  "💭",
  "🗯",
  "♠",
  "♣",
  "♥",
  "♦",
  "🃏",
  "🎴",
  "🀄",
  "🕐",
  "🕑",
  "🕒",
  "🕓",
  "🕔",
  "🕕",
  "🕖",
  "🕗",
  "🕘",
  "🕙",
  "🕚",
  "🕛",
  "🕜",
  "🕝",
  "🕞",
  "🕟",
  "🕠",
  "🕡",
  "🕢",
  "🕣",
  "🕤",
  "🕥",
  "🕦",
  "🕧"
];
