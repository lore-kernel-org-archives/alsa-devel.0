From: Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.28-rc2-mm1 - sound semi-busted on Dell Latitude D820
Date: Tue, 11 Nov 2008 13:25:56 -0500
Message-ID: <5241.1226427956@turing-police.cc.vt.edu>
References: <4411.1226345758@turing-police.cc.vt.edu> <s5hljvqzot1.wl%tiwai@suse.de> <s5hprl2yz39.wl%tiwai@suse.de>
            <s5hmyg6yz0n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1226427956_3887P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755473AbYKKS0r@vger.kernel.org>
In-Reply-To: Your message of "Tue, 11 Nov 2008 18:04:56 +0100."
             <s5hmyg6yz0n.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, perex@perex.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--==_Exmh_1226427956_3887P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 Nov 2008 18:04:56 +0100, Takashi Iwai said:

> > Could you try the patch below?

> > There is another patch for a missing capture mux control, but in your
> > case, it doesn't matter because you didn't change the value.
> > I'll post that patch later, too.
> 
> Here is another fix.

Thanks for the fast reply for admittedly not-major problem.  I'll give
these patches a try tonight and report back tomorrow how things went...


--==_Exmh_1226427956_3887P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFJGc40cC3lWbTT17ARAvDlAJ9qUzwgQTseaMyTaw5b+uu0scbexACcDhDV
i8z8uxjPs/ABTc9DaADlGEQ=
=wYS5
-----END PGP SIGNATURE-----

--==_Exmh_1226427956_3887P--
