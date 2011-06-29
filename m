From: Daniel Mack <zonque@gmail.com>
Subject: Re: M-Audio FTU issues
Date: Wed, 29 Jun 2011 10:08:50 +0200
Message-ID: <BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
	<4E045058.6000405@showlabor.de>
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>
	<4E04B42E.2080906@ladisch.de>
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1174810386D
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 10:08:51 +0200 (CEST)
Received: by pvg18 with SMTP id 18so724949pvg.38
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2011 01:08:50 -0700 (PDT)
In-Reply-To: <BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 28, 2011 at 10:37 PM, Aur=E9lien Leblond <blablack@gmail.com> w=
rote:
> Hi Daniel,
>
> All clicks gone as Felix already said :)

Good.

> And confirmed, the kernel crashed with playback and capture streams
> started at the same time :)

I'd like to discuss the API for the ALSA/USB decoupling as suggested
by Clemens, which will solve this problem then.

Thanks,
Daniel
