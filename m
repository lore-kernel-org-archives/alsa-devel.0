From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: Creative/emu10k1 status?
Date: Fri, 14 Nov 2003 20:33:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S19421AbTKNSdA/20031114183300Z+1380@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, emu10k1-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello. What is the latest status of Creative/emu10k1 support?

I have Alsa driver where the LiveDrive Line-In2 ("Line LiveDrive 1")
on capture bus does not work. We checked the case with Alsa developers
but the problem remained. A quick look at the Alsa-Devel archives
reveals that others have had the same problem this year.

Before anyone jumps and tell that they are able to record from
the Line-In2, I can tell that that is possible via AC97, which
is wrong way.

 !! If you think your capture works, mail me and we   !!
 !! *verify* it together with my test mixer settings. !!

I have written many months ago to Creative people that they could
install and fix the Alsa driver theirself as they have the docs.
Then, when Alsa works, they could look at the modifications and
decide if the mods goes around their NDA. Anyone at Creative?

I have Alsa but would like to test the other driver from Sourceforge.
How do I test the other driver with Alsa? Does the other driver
work as a standalone driver without Alsa or OSS? Is OSS a module as
well? Do I have to recompile kernel? Would somebody like to write
simple installation instructions for going from Alsa to the other
driver?

Would anyone expert like to test and compare both drivers? Specially
if we find out you have the problem too. If you think it is easy
for me to test the drivers myself, then you're the volunteer I'm
thinking of. ;-)

Regards,
Juhana


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
