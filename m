From: Pierre-Antoine Champin <alsa-050822@champin.net>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Wed, 02 Nov 2005 13:47:51 +0100
Message-ID: <4368B577.3060502@champin.net>
References: <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com>	 <Pine.HPX.4.33n.0510281416340.24464-100000@studcom.urz.uni-halle.de>	 <8a0c36780510281134gce42934v61b094b072d8f841@mail.gmail.com> <1130525389.4363.53.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1130525389.4363.53.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Lee Revell <rlrevell@joe-job.com>, Richard Smith <smithbone@gmail.com>
List-Id: alsa-devel@alsa-project.org

Richard Smith wrote :
> Why would it only doing USB 1.1?  I thought this was USB 2.0 device.

Are you sure ?
I bought an Audiophile USB a few months ago, I seem to remember it is
USB 1.1 only...
(or did M-Audio release a new one?)

Lee Revell a =C3=A9crit :
> Keep in mind that 24/96 full duplex over USB 1.1 is really pushing the
> USB bandwidth limits.  Most people I talk to report that this doesn't
> work reliably on any OS.

I confirm: according to
  http://www.m-audio.com/products/en_us/AudiophileUSB-focus.html

USB recording:
 	=E2=80=A2 16-bit/44.1kHz > 4-in/4-out
 	=E2=80=A2 24-bit/44.1kHz > 4-in/2-out or 2-in/4-out
 	=E2=80=A2 24-bit/48kHz > 4-in/2-out or 2-in/4-out
 	=E2=80=A2 24-bit/96kHz > 2-in or 2-out
 	                      ^^

I also has trouble with the Audiophile, but hadn't have much time to
test it for quite a long time now. As soon as I find time to compile
kernel 2.6.14, I'll give it a try with all this new information.

  pA


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
