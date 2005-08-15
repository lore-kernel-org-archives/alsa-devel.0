From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Compulab sound device
Date: Sun, 14 Aug 2005 20:06:41 -0700 (PDT)
Message-ID: <20050815030641.94973.qmail@web54605.mail.yahoo.com>
References: <s5hu0hyyvf1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0hyyvf1.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi All,

I got a question here. Does ALSA support ac97 codec as
a soundcard? Im not too sure whether ac97 can work on
the Compulab Armcore board. This is because when i
type "cat /proc/asound/devices", all i get is this.

[root@ARMCore root]$ cat /proc/asound/devices
 33:       : timer

Does this mean that i got it wrong during building my
kernel? Or does this mean that the ac97 interface in
the armcore is not supported by ALSA?

Please advice me. Hope to hear from you guys soon.

Thanks.

Regards

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
