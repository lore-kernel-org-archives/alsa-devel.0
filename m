From: John Rigg <ad@sound-man.co.uk>
Subject: Re: envy24control word clock error
Date: Mon, 28 Nov 2005 20:04:50 +0000
Message-ID: <20051128200450.GA4458@localhost.localdomain>
References: <E1EgS8o-0001CV-7k@localhost.localdomain> <s5h64qclm29.wl%tiwai@suse.de> <20051128180500.GH10146@edu.joroinen.fi> <s5hzmnok597.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hzmnok597.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2005 at 07:16:04PM +0100, Takashi Iwai wrote:
> At Mon, 28 Nov 2005 20:05:00 +0200,
> Pasi K=E4rkk=E4inen wrote:
> >=20
> > On Mon, Nov 28, 2005 at 06:27:42PM +0100, Takashi Iwai wrote:
> > > At Sun, 27 Nov 2005 19:24:50 +0000,
> > > John Rigg wrote:
> > > >=20
> > > > When I start envy24control from xterm I get an endless stream of
> > > > "Unable to determine wordclock status: No such file or directory"=
 and
> > > > "Unable to read word clock sync selection: No such file or direct=
ory" error
> > > > messages.
> > >=20
> > > Try the patch below.
> >=20
> > That patch fixes the problem for me! (Debian sid/unstable,=20
> > alsa-tools-gui 1.0.10-1)
>=20
> Thanks for confirmation.  I applied it to CVS, too.
>=20
>=20
> Takashi

Just for further confirmation, it works here too. Now I can sync word
clocks :)

Thanks,
John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
