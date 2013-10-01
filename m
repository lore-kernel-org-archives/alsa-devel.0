From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Problems with i.MX233 driver in 3.12rc2
Date: Tue, 1 Oct 2013 09:54:11 -0300
Message-ID: <CAOMZO5DmAKApO4RtdWKKHb3c14MzZOFQWz4Q01pE-BngTrMvPw@mail.gmail.com>
References: <CAG8Y82pXO3ZFGG75fY4ggSTpNQ4wF2j=mmVuw3XmWxKSdT2Y=Q@mail.gmail.com>
 <20131001114127.GN19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f177.google.com (mail-ve0-f177.google.com
 [209.85.128.177])
 by alsa0.perex.cz (Postfix) with ESMTP id E26AF264F13
 for <Alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 14:54:12 +0200 (CEST)
Received: by mail-ve0-f177.google.com with SMTP id db12so5022280veb.8
 for <Alsa-devel@alsa-project.org>; Tue, 01 Oct 2013 05:54:12 -0700 (PDT)
In-Reply-To: <20131001114127.GN19304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Trevor Page <trevg60@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, "alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 1, 2013 at 8:41 AM, Mark Brown <broonie@kernel.org> wrote:

>>  sound/soc/codecs/mxs-builtin-codec.c
>> sound/soc/mxs/mxs-builtin-audio.c
>>  sound/soc/mxs/mxs-builtin-dai.c
>> sound/soc/mxs/mxs-builtin-pcm.c
>
> These aren't in mainline?

Yes, not yet.

Trevor, please work with the driver author to get it submitted to this
list, so that it can be properly reviewed.

Thanks,

Fabio Estevam
