From: "Stephen Warren" <SWarren@nvidia.com>
Subject: RE: New azx driver: Problems in snd_mixer_load
Date: Fri, 10 Dec 2004 10:05:40 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE1BA@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

From: Takashi Iwai [mailto:tiwai@suse.de]=20
> Stephen Warren wrote:
> > I've installed the latest CVS drivers, CVS alsa-lib and CVS=20
> > alsa-utils. I still get the same error during alsa-lib
> > initialization whilst running alsamixer.
>=20
> The anonymous CVS tree on sourceforge isn't sync'ed often, maybe once
> per day.  I guess you'ure using still old version.  Wait for a while
> until the tree gets sync'ed.

I'm on the latest code - I copied my CVS tree before updating, and then
diff'd the old and new trees. All the changes that show up in the
web-based CVS browser at the URL below are in my copy of the code:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-driver/pci/azx/

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
