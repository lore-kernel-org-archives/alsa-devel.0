From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 09:56:37 +0100
Message-ID: <4F1537C5.3010909@ti.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CABS+qY1rcDjxEcbR6df5mdV4n105Cf_Sis5QOOV6zZG+Sx34gg@mail.gmail.com>
	<20120116224238.GA2859@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73]) by alsa0.perex.cz (Postfix) with ESMTP id 4C18424550
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 09:56:46 +0100 (CET)
Received: by mail-yx0-f181.google.com with SMTP id m11so1575586yen.12
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 00:56:40 -0800 (PST)
In-Reply-To: <20120116224238.GA2859@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/16/2012 11:42 PM, Mark Brown wrote:
> On Mon, Jan 16, 2012 at 10:26:11PM +0000, Girdwood, Liam wrote:
> =

>> Btw, will you be reworking Peter's patch ?
> =

> Probably if he doesn't get around to it, though I figured that the patch
> is so tiny it's probably going to be less work to just write it when
> testing rather than to apply a patch from mail so it'd be easier for him
> to let him do it.

I'll update the drivers (cpu dais, and codecs I know have this feature).

-- =

P=E9ter
