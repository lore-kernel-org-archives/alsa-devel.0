From: albox@free.fr
Subject: Issue with Intel HDA Sound card 82801G (laptop Medion)
Date: Sat, 07 Oct 2006 15:24:21 +0200
Message-ID: <1160227460.4527aa8501646@imp1-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I sent an email 2 weeks ago about an issue with my sound card : Intel HDA Sound
card 82801G (laptop Medion).
http://sourceforge.net/mailarchive/forum.php?thread_id=30643877&forum_id=1752

It seems that I'm not the only person having an issue with this sound card :
http://sourceforge.net/mailarchive/forum.php?thread_id=30685342&forum_id=1752

Tobin Davis answered me and helped me but I didn't fix the bug yet.
I tried adding "options snd model=acer" to my /etc/modprobe.conf file with the
last version of the asla drivers...
Next Tobin asked me for the log messages but he didn't answer me yet (I guess he
is too busy). So, I want to try to fix the problem by myself but I'd like some
help to start. Can somebody tell me where can I start to look to detect the
problem ?

Thank you

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
