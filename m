From: "Ivica Bukvic" <ico@fuse.net>
Subject: question regarding latest CS4205 laptop soundcard driver
Date: Mon, 25 Feb 2002 19:11:02 -0500
Message-ID: <000001c1be5a$13453000$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all!

I have a quick question regarding the latest CrystalClear soundcard that
is found in Dell Inspirons and other laptops (model name CS4205).

My understanding is that the maker of this DSP chip is rather Linux
friendly, so my question is does the driver for this soundcard (which I
believe is Intel810 and has been reported to be working in Linux)
supports hardware mixing (i.e. opening sound device multiple times as is
the case with SBLive!), since this card also advertises having hardware
mixer like SBLive! does. I=92ve also heard that most other modern
mainstream soundcards have that capability and some of them simply =
don=92t
do that due to lack of documentation (i.e. Ess maestro 3i). So what is
then the case with this one and how does it stack-up against other
mobile built-in soundcards?

Finally, my last question is whether anyone has had any experience with
Dell=92s new line of Inspirons 4100 which have only one fan and have =
been
relatively altered from the old 4000/8000 models, also whether anyone
knows if that model still has the fan bug like the inspirons 4000/8000
do?

Any help would be greatly appreciated! Sincerely,

Ivica Ico Bukvic, composer, multimedia sculptor,
programmer, webmaster & computer consultant
http://meowing.ccm.uc.edu/~ico/
ico@fuse.net
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
"To be is to do"=A0=A0 - Socrates
"To do is to be"=A0=A0 - Sartre
"Do be do be do"=A0=A0 - Sinatra
"I am"=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - God




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
