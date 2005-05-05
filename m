From: "Gary E. Miller" <gem@rellim.com>
Subject: Re: intel-hda on medion laptop
Date: Thu, 5 May 2005 14:25:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0505051422190.31406@catbert.rellim.com>
References: <20050505210932.GA8016@blackmilk.localzone.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050505210932.GA8016@blackmilk.localzone.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: fab <fab@gnux.info>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yo fab!

I have a laptop and a desktop with the ICH5 sound. Not had any luck getting
either to work since Alsa 1.0.4.

Anything in the dmesg buffer? Can you send the contents of your
/proc/asound/cards and /proc/sound/devices?  Anything in your
/etc/asound.conf?


RGDS
GARY
- ---------------------------------------------------------------------------
Gary E. Miller Rellim 20340 Empire Blvd, Suite E-3, Bend, OR 97701
	gem@rellim.com  Tel:+1(541)382-8588 Fax: +1(541)382-8676

On Thu, 5 May 2005, fab wrote:

> I own a brand new medion laptop with an ICH6 family sound card.
> With the latest alsa-drivers (cvs) I get no sound on speakers nor
> headphones output. The 3 bottom outputs works depending on the "model"
> option but have *very* low sound of *very* bad quality on them
> (generally, only the Front & Center works).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCeo878KZibdeR3qURAq4eAJ0Ywfl43R55V7I5TcACNOgNpCAgUQCdHUCB
YawS0gmfxp05XHa1Z/R94y4=
=WyCz
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
