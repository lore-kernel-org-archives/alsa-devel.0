From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Re: Full Duplex audio using ALSA [Through UDP] .
Date: Tue, 10 May 2005 13:55:22 +0200
Message-ID: <20050510115522.GB29728@stud.ntnu.no>
References: <20050510112537.23622.qmail@web8310.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050510112537.23622.qmail@web8310.mail.in.yahoo.com>
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
Cc: Koushik jaikishan <jaykishankrk@yahoo.co.in>
List-Id: alsa-devel@alsa-project.org

On Tue, May 10, 2005 at 12:25:37PM +0100, Koushik jaikishan wrote:
>=20
> hello all,
> the present work of mine is in the area of transfering
> audio through UDP.

So is mine.

> [problem description snipped ]

> please let me know the possible solution to
> get audio through UDP.=20

I have no answer to your programming problems.  (And I probably would=20
not have even if it was well described, which it is not.)

One possible solution to your task is to use jack.udp and udp.sync. =20
As far as I have understood it (I may be wrong), this solution does
not deal with all problems that may arise when doing what you are trying
to do.  But it may still be useful to you.

I am working on a project similar to yours myself (<URL: =20
http://www.q2s.ntnu.no/~asbjs/ldas/ldas.html >).  If this ends up in a
releaseable state, it is possible that it will one day be released.

(Please reply to the list, not directly to me.)

Asbj=F8rn



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
