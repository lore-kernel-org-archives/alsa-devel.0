From: Fabio Estevam <festevam@gmail.com>
Subject: Re: mx6: Audio does not work on linux-next 20140107
Date: Wed, 8 Jan 2014 13:33:01 -0200
Message-ID: <CAOMZO5BMJh-GwfOZcS0m-cW+EEOka7SRbExwu9mMx2xOEB__Nw@mail.gmail.com>
References: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
 <52CBEDFA.10603@metafoo.de>
 <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
 <20140107122813.GA6750@MrMyself>
 <CAOMZO5AC5n-intSnUdnBJyYVO2O2BfPYMj_SwNP6jXD5qxVp9g@mail.gmail.com>
 <CAOMZO5DD-SXe9GKdvTEPccJe5rhR4zVNQF=Of1iUsbqrBtAXPg@mail.gmail.com>
 <20140108050431.GD6750@MrMyself>
 <CAOMZO5C0_aEzSB+fJuyfxCisojUewS9i33kA4-rVB2-NHaFOgw@mail.gmail.com>
 <20140108095301.GA12854@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f173.google.com (mail-ve0-f173.google.com
 [209.85.128.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 4738F261A9F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 16:33:02 +0100 (CET)
Received: by mail-ve0-f173.google.com with SMTP id oz11so1381294veb.32
 for <alsa-devel@alsa-project.org>; Wed, 08 Jan 2014 07:33:01 -0800 (PST)
In-Reply-To: <20140108095301.GA12854@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 8, 2014 at 7:53 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:

> Yea, Shawn just told me there's an inner firmware in the ROM code while
> this firmware only supports some basic scripts. And I've already sent
> my fixing patches (you're in the to list). Please take a look and test
> if you can.

Your patches fix the issue. Thanks, Nicolin.
