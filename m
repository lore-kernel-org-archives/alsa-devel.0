From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: CMI8768 patch
Date: Thu, 24 Feb 2005 18:42:28 +0000
Message-ID: <1109270548.3789.5.camel@bastov>
References: <92C0412E07F63549B2A2F2345D3DB515F7D65D@cm-msg-02.cmedia.com.tw>
	 <1109218822.1244.35.camel@bastov>  <s5hu0o25jxj.wl@alsa2.suse.de>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <s5hu0o25jxj.wl@alsa2.suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-02-24 at 11:30 +0100, Takashi Iwai wrote:
> At Thu, 24 Feb 2005 04:20:22 +0000,
> Sergio Monteiro Basto wrote:
> >=20
> >=20
> > About my : C-Media CMI9761A
> >=20
> > With this change above and compile ALSA from latest CVS, PCM and Mast=
er
> > volume appears !, PCM works great but master doesn't do nothing !=20
>=20
> It's a known problem.  I readded Master volume because of the report
> that it affects the input loop-back.  If it's not, we should remove
> it.

How I remove it ? for testing and give you a feed-back.=20

thanks,
>=20
>=20
> Takashi
--=20
S=E9rgio M.B.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
