From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: Re: [PATCH] ASoC: SDP3430: Fix TWL GPIO6 pin mux
	request
Date: Tue, 25 Aug 2009 10:04:46 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B72A1D824@dlee01.ent.ti.com>
References: <2256F256009DAA4CBE661E9F41EAC84B72A1D4E3@dlee01.ent.ti.com>
	<20090825100457.GA30000@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D1D6244F3
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 17:04:53 +0200 (CEST)
In-Reply-To: <20090825100457.GA30000@rakim.wolfsonmicro.main>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter@alsa-project.org, Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

> On Mon, Aug 24, 2009 at 07:04:50PM -0500, Candelaria 
> Villareal, Jorge wrote:
> > Fix the write to PMBR1 register through I2C. Also, the 
> constant which
> > holds the value to write is now called TWL4030_GPIO6_PWM0_MUTE. This
> > name is based on TRM to avoid confusion.
> 
> > Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
> 
> Your patch doesn't apply - it looks like your mail program may have
> mangled it in some interesting fashion and replaced all the tabs with
> single spaces but I'm not 100% sure.  Could you please look 
> into what's
> happened here?
> 
>

Yes, it seems all the tabs have been replaced with single spaces. I have
corrected the problem and will resend in a few minutes.
