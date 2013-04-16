From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v3 00/15] ASoC: fsl-ssi: ac97-slave support
Date: Mon, 15 Apr 2013 19:25:43 -0500
Message-ID: <516C9A87.4090307@tabi.org>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
 <516A9D5B.2070707@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <516A9D5B.2070707@metafoo.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen wrote:
>> >@Lars:
>> >There are 4 new patches at the beginning of the series that fix some problems
>> >of your cleanups. I think they were in the changes you posted. If not, could you
>> >please add them to your branch?
> Hi,
>
> I had already fixed them localy. I'm in the process of polishing the last bits
> and pieces of my generic dmaengine PCM driver series right now and will submit
> it later today.

So which repository should I apply these patches to?  I want to make sure 
they don't break PowerPC.

-- 
Timur Tabi
