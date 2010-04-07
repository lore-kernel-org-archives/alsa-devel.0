From: "Marcus Weigelt" <noize007@gmx.de>
Subject: Re: User-space control elements in ext PCM plugin
Date: Wed, 07 Apr 2010 14:22:47 +0200
Message-ID: <20100407122247.247630@gmx.net>
References: <20100407100104.41190@gmx.net> <hphqhb$839$1@dough.gmane.org>
	<20100407115433.60020@gmx.net>
	<alpine.LNX.2.00.1004071357040.3925@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id DBA961038E7
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 14:22:48 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1004071357040.3925@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yes, I think the softvol plugin is the closest thing to what I want to do.
So I think I will just try it :) Thanks for your support!

Marcus

-------- Original-Nachricht --------
> Datum: Wed, 7 Apr 2010 13:58:40 +0200 (CEST)
> Von: Jaroslav Kysela <perex@perex.cz>
> An: Marcus Weigelt <noize007@gmx.de>
> CC: alsa-devel@alsa-project.org
> Betreff: Re: [alsa-devel] User-space control elements in ext PCM plugin

> On Wed, 7 Apr 2010, Marcus Weigelt wrote:
> =

> > That=B4s where I got the idea of creating the user-space control elemen=
ts
> > directly inside of the PCM plugin, or did I get it wrong?
> =

> The build-in softvol plugin uses this mechanism. But I'm not sure, if this
> way is supported in the external PCM plugins interface.
> =

>  						Jaroslav
> =

> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.

-- =

GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
