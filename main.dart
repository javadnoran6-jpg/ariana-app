import 'package:flutter/material.dart';

const bg = Color(0xFF14052E);
const card = Color(0xFF2A0F55);
const neon = Color(0xFFB026FF);
const gold = Color(0xFFFFC83D);
const pink = Color(0xFFFF4FD8);

final diamonds = ValueNotifier<int>(300);
final coins = ValueNotifier<int>(60);
final txs = ValueNotifier<List<String>>(['دریافت جایزه روزانه|+60']);

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'آریانا',
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: bg,
            colorScheme: const ColorScheme.dark(primary: neon, secondary: gold)),
        builder: (c, w) =>
            Directionality(textDirection: TextDirection.rtl, child: w!),
        home: const Login(),
      );
}

class GBtn extends StatelessWidget {
  final String t;
  final VoidCallback f;
  final bool yellow;
  const GBtn(this.t, this.f, {super.key, this.yellow = false});
  @override
  Widget build(BuildContext c) => GestureDetector(
        onTap: f,
        child: Container(
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
                colors: yellow
                    ? [gold, const Color(0xFFFF9F1C)]
                    : [neon, const Color(0xFF6A2CFF)]),
          ),
          child: Text(t,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: yellow ? Colors.black : Colors.white)),
        ),
      );
}

Widget av(String n, {double r = 24, bool online = false}) => Stack(children: [
      CircleAvatar(
          radius: r,
          backgroundColor: neon,
          child: Text(n.characters.first,
              style: TextStyle(fontSize: r * .8, color: Colors.white))),
      if (online)
        Positioned(
            bottom: 0,
            left: 0,
            child: CircleAvatar(radius: r * .22, backgroundColor: Colors.greenAccent)),
    ]);

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF5B1AA8), bg])),
          padding: const EdgeInsets.all(24),
          child: SafeArea(
            child: Column(children: [
              const Spacer(),
              const Text('ARIANA',
                  style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: gold,
                      letterSpacing: 3)),
              const Text('💜 آریانا 💜',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('دوستی . سرگرمی . هیجان',
                  style: TextStyle(fontSize: 16, color: Colors.white70)),
              const Spacer(),
              GBtn('ورود به حساب', () => go(c)),
              const SizedBox(height: 14),
              GBtn('ثبت نام جدید', () => go(c), yellow: true),
              const SizedBox(height: 14),
              const Text('ورود با شماره موبایل',
                  style: TextStyle(color: Colors.white60)),
            ]),
          ),
        ),
      );
  void go(BuildContext c) => Navigator.pushReplacement(
      c, MaterialPageRoute(builder: (_) => const Shell()));
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _S();
}

class _S extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext c) => Scaffold(
        body: SafeArea(
            child: IndexedStack(index: i, children: const [
          Home(),
          Ranking(),
          Groups(),
          Messages(),
          Profile()
        ])),
        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color(0xFF1E0A42),
          indicatorColor: neon.withOpacity(.4),
          selectedIndex: i,
          onDestinationSelected: (v) => setState(() => i = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'خانه'),
            NavigationDestination(
                icon: Icon(Icons.emoji_events), label: 'رتبه‌بندی'),
            NavigationDestination(icon: Icon(Icons.groups), label: 'گروه‌ها'),
            NavigationDestination(icon: Icon(Icons.chat), label: 'پیام‌ها'),
            NavigationDestination(icon: Icon(Icons.person), label: 'پروفایل'),
          ],
        ),
      );
}

const people = ['دوست عزیز', 'گروه آریانا', 'الینا', 'مهسا', 'گروه دخترای خاص', 'امیر'];
const lastMsg = ['عالی بود 💜', 'عکس ارسال شد', 'سلام عزیزم 🌸', 'خخخخ 😍', 'خوش اومدی 💗', 'شب بخیر 🌙'];
const groupNames = ['آریانا گیم', 'دختری خاص', 'عشق و محبت', 'گروه موسیقی', 'دوستان صمیمی'];
const members = ['28.5K', '18.6K', '15.2K', '12.9K', '11.7K'];

Widget title(String t) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));

Widget chip(IconData ic, Color col, ValueNotifier<int> n) => ValueListenableBuilder<int>(
    valueListenable: n,
    builder: (_, v, __) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(20)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(ic, color: col, size: 20),
            const SizedBox(width: 6),
            Text('$v', style: const TextStyle(fontWeight: FontWeight.bold)),
          ]),
        ));

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext c) => ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            av('پ', r: 26, online: true),
            const SizedBox(width: 10),
            const Expanded(
                child: Text('پریا چش رنگی 👑\nLv.24 • آنلاین',
                    style: TextStyle(height: 1.5))),
            chip(Icons.diamond, Colors.cyanAccent, diamonds),
            const SizedBox(width: 8),
            chip(Icons.monetization_on, gold, coins),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [neon, pink])),
          child: Row(children: [
            const Text('🎁', style: TextStyle(fontSize: 46)),
            const SizedBox(width: 12),
            const Expanded(
                child: Text('جایزه روزانه\nتا ۱۰۰ الماس',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
                onPressed: () {
                  diamonds.value += 50;
                  txs.value = ['دریافت جایزه روزانه|+50', ...txs.value];
                  ScaffoldMessenger.of(c).showSnackBar(
                      const SnackBar(content: Text('۵۰ الماس دریافت شد')));
                },
                child: const Text('دریافت')),
          ]),
        ),
        title('دوستان آنلاین (256)'),
        SizedBox(
            height: 60,
            child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  for (final p in people)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: av(p, r: 28, online: true))
                ])),
        title('گروه‌های برترهزار'),
        SizedBox(
            height: 110,
            child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  for (int k = 0; k < 3; k++)
                    GestureDetector(
                      onTap: () => Navigator.push(c,
                          MaterialPageRoute(builder: (_) => Chat(groupNames[k]))),
                      child: Container(
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(16)),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            av(groupNames[k], r: 26),
                            const SizedBox(height: 8),
                            Text(groupNames[k], style: const TextStyle(fontSize: 13)),
                          ])),
                    )
                ])),
        title('بازی‌های سرگرمی'),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              for (final g in ['بوکر', 'منچ', 'لودو'])
                Expanded(
                    child: Container(
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(colors: [Color(0xFF6A2CFF), neon])),
                        child: Text(g, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))))
            ])),
        const SizedBox(height: 16),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GBtn('فروشگاه الماس 💎', () => Navigator.push(c, MaterialPageRoute(builder: (_) => const Store())), yellow: true)),
        const SizedBox(height: 16),
      ]);
}

class Ranking extends StatelessWidget {
  const Ranking({super.key});
  @override
  Widget build(BuildContext c) => ListView(children: [
        title('رتبه‌بندی گروه‌ها'),
        for (int k = 0; k < 5; k++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(16),
                border: k == 0 ? Border.all(color: gold, width: 2) : null),
            child: Row(children: [
              Text('${k + 1}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: k == 0 ? gold : Colors.white)),
              const SizedBox(width: 12),
              av(groupNames[k]),
              const SizedBox(width: 12),
              Expanded(child: Text(groupNames[k], style: const TextStyle(fontSize: 16))),
              Text('${(250 - k * 40)},000 امتیاز', style: const TextStyle(color: Colors.white70)),
            ]),
          ),
      ]);
}

class Groups extends StatelessWidget {
  const Groups({super.key});
  @override
  Widget build(BuildContext c) => ListView(children: [
        title('گروه‌ها'),
        for (int k = 0; k < 5; k++)
          ListTile(
            leading: av(groupNames[k], online: true),
            title: Text('${groupNames[k]} 👑'),
            subtitle: Text('${members[k]} عضو'),
            onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => Chat(groupNames[k]))),
          ),
        Padding(
            padding: const EdgeInsets.all(16),
            child: GBtn('+ ساخت گروه', () => ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content: Text('ساخت گروه در مرحله بعد با سرور فعال می‌شود'))))),
      ]);
}

class Messages extends StatelessWidget {
  const Messages({super.key});
  @override
  Widget build(BuildContext c) => ListView(children: [
        title('پیام‌ها'),
        for (int k = 0; k < people.length; k++)
          ListTile(
            leading: av(people[k], online: true),
            title: Text(people[k]),
            subtitle: Text(lastMsg[k]),
            trailing: Text('21:${30 - k * 5}', style: const TextStyle(color: Colors.white54)),
            onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => Chat(people[k]))),
          ),
      ]);
}

class Chat extends StatefulWidget {
  final String name;
  const Chat(this.name, {super.key});
  @override
  State<Chat> createState() => _C();
}

class _C extends State<Chat> {
  final ctl = TextEditingController();
  final msgs = <String>['سلام 💜'];
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(backgroundColor: card, title: Text(widget.name)),
        body: Column(children: [
          Expanded(
              child: ListView(padding: const EdgeInsets.all(12), children: [
            for (final m in msgs)
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: neon, borderRadius: BorderRadius.circular(16)),
                      child: Text(m)))
          ])),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                Expanded(
                    child: TextField(
                        controller: ctl,
                        decoration: InputDecoration(
                            hintText: 'پیام...',
                            filled: true,
                            fillColor: card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none)))),
                IconButton(
                    icon: const Icon(Icons.send, color: neon),
                    onPressed: () {
                      if (ctl.text.trim().isEmpty) return;
                      setState(() => msgs.add(ctl.text.trim()));
                      ctl.clear();
                    }),
              ])),
        ]),
      );
}

class Store extends StatelessWidget {
  const Store({super.key});
  @override
  Widget build(BuildContext c) {
    const pk = [[2, '28'], [16, '80'], [200, '499,000'], [400, '1,300,000']];
    return Scaffold(
      appBar: AppBar(backgroundColor: card, title: const Text('فروشگاه آریانا')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        for (final p in pk)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: const Icon(Icons.diamond, color: Colors.cyanAccent, size: 34),
              title: Text('${p[0]} الماس', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${p[1]} تومان'),
              trailing: ElevatedButton(
                  onPressed: () {
                    diamonds.value += (p[0] as int);
                    txs.value = ['خرید الماس|+${p[0]}', ...txs.value];
                    ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content: Text('خرید آزمایشی انجام شد (درگاه واقعی در مرحله بعد)')));
                  },
                  child: const Text('خرید')),
            ),
          ),
      ]),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext c) => ListView(padding: const EdgeInsets.all(16), children: [
        Center(child: av('پ', r: 44, online: true)),
        const SizedBox(height: 8),
        const Center(child: Text('پریا چش رنگی 👑', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        title('کیف پول من'),
        Row(children: [
          chip(Icons.diamond, Colors.cyanAccent, diamonds),
          const SizedBox(width: 10),
          chip(Icons.monetization_on, gold, coins),
        ]),
        title('آخرین تراکنش‌ها'),
        ValueListenableBuilder<List<String>>(
            valueListenable: txs,
            builder: (_, l, __) => Column(children: [
                  for (final t in l)
                    ListTile(
                        title: Text(t.split('|')[0]),
                        trailing: Text(t.split('|')[1],
                            style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)))
                ])),
        GBtn('خرید الماس', () => Navigator.push(c, MaterialPageRoute(builder: (_) => const Store())), yellow: true),
      ]);
}
