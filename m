From: Antonio Gigetto <undergroundtango@tiscali.it>
Subject: A few problems with the powermac driver
Date: Tue, 19 Aug 2003 15:41:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DBF8E26E-D24A-11D7-A645-000A27B0EF80@tiscali.it>
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi
I have an iMac DV 400 ( here are the specs
http://docs.info.apple.com/article.html?artnum=43099 ).
I tried alsa with the powermac driver in the latest kernel source
(2.6.0-test3) and also the latest alsa release (0.9.6) with kernel 2.4.0
and in both cases i found the following problems:
-when plugging a headphone in one of the front jacks the speakers are
muted (cool) but i also can't hear any sound from the headphones! The
only workaround to this is to manually increase the level of the PC
speaker: this way i can hear audio from the headphones but it also comes
out from the speakers so the headphones are pretty useless.
-If i plug the headphones in the line-out jack on the side of the
computer, again the speakers are muted (yay) and this time i also hear
sound from the headphones (yay!) but no matter how low the volume is, it
has a horrible distortion. I'm just stuck using the speakers (which in
my case are broken so it's pretty annoying)
Is anybody still working on the driver? I'm available for any question.
Thanks in advance
Antonio



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
