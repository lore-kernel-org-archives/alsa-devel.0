From: Gregory T Flynn <gflynn1@binghamton.edu>
Subject: Re: no soundcards detected on MCP51 rev a
Date: Wed, 14 Apr 2010 14:19:20 -0400
Message-ID: <k2ib98465221004141119s4e20d1c4yff1df888940dbbc2@mail.gmail.com>
References: <i2qb98465221004131406ze558772bq74e2ffac68e1f12a@mail.gmail.com>
	<r2m604760771004131619p2ac8d6fasb387dccb325a55ae@mail.gmail.com>
	<v2rb98465221004131834o14d1d48brba3a39da322e2011@mail.gmail.com>
	<y2rb98465221004140547m50808d75q5a896bea789b655e@mail.gmail.com>
	<s5hvdbuvx2n.wl%tiwai@suse.de>
	<m2ub98465221004141044ub0cb4628zbebdc7a0a4e02524@mail.gmail.com>
	<s5hd3y15285.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8C26424543
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 20:19:21 +0200 (CEST)
Received: by vws1 with SMTP id 1so175346vws.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2010 11:19:20 -0700 (PDT)
In-Reply-To: <s5hd3y15285.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

after 9.04 it doesn't work, and versions of ALSA prior to 1.0.20 won't
compile against the newer kernels since the source tree organization
has changed

On Wed, Apr 14, 2010 at 2:16 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 14 Apr 2010 13:44:13 -0400,
> Gregory T Flynn wrote:
>>
>> the options in the laptop's BIOS are rather sparse and nothing about
>> Sound card enable/disable
>>
>> The soundcard works in Windows 7 and Ubuntu 8.04/8.10/9.04 Live USB imag=
es
>
> Then try the version of alsa-driver of Ubuntu. =A0Check whether it
> really works. =A0If works, then please bisect.
>
>
> thanks,
>
> Takashi
>



-- =

- Greg Flynn
