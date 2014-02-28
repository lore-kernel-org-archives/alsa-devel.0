From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 07/11] ASoC: mc13783: Use
	SOC_ENUM_SINGLE_VIRT_DECL()
Date: Fri, 28 Feb 2014 08:19:46 +0100
Message-ID: <53103892.2070502@metafoo.de>
References: <1393168221-23018-1-git-send-email-lars@metafoo.de>
 <1393168221-23018-8-git-send-email-lars@metafoo.de>
 <530B5719.8000507@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id D809F2650A4
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 08:19:16 +0100 (CET)
In-Reply-To: <530B5719.8000507@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

On 02/24/2014 03:28 PM, Philippe R=E9tornaz wrote:
> Le 23/02/2014 16:10, Lars-Peter Clausen a =E9crit :
>> For the upcoming consolidation for MUXs and virtual MUXs we need to mark
>> virtual
>> enums as such.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>
> Tested on mx31moboard, no regression.
>
> Thanks,
>
> Philippe
>

Thanks, I'll add a Tested-by tag from you.
