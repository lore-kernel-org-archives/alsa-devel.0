From: Chuckles <chuckleberryfinn@gmail.com>
Subject: Alsa Mixer api documentation.
Date: Mon, 25 Jul 2005 01:46:37 +0200
Message-ID: <29d8345905072416467aa8dc4d@mail.gmail.com>
Reply-To: Chuckles <chuckleberryfinn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hello,
      I am trying to find a clear example, tutorial or guide to the
alsa mixer api. The documentation generated in the doxygen
subdirectory of the doc subdirectory of the alsa-lib package is not
very clear. The index page of the library api documentation does
contain a link to some mixer info:
                           =20
                             API Links
                ........
                Page Mixer interface explains the mixer controls API.
                ........

But that link contains:

               Mixer interface

             Mixer interface is designed to access the abstracted
mixer controls. This is an            abstraction layer over the
hcontrol layer.

General overview=20

And that's it, there is nothing under the heading General Overview. I
have found some of the method prototypes are documented but they are a
bit ambiguous in regards to the actual functions they perform.
(snd_mixer_first_elem) Michal Kochanowicz previously sent an email
about this with subject
'Mixer programming - is there any documentation available?'
So...is there? If anyone can even give me a simple "open mixer, set
pcm to 50%, close mixer" example that'd be great.
Thanks for any and all help,

Cathal


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
