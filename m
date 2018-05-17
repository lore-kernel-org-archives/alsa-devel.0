From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] ASoC: ssm2305: Add amplifier driver
Date: Thu, 17 May 2018 16:44:32 +0200
Message-ID: <399c5202-143b-3c4f-5399-aa6022859ddc@metafoo.de>
References: <20180517135518.29345-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 374A72671C0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 16:44:37 +0200 (CEST)
In-Reply-To: <20180517135518.29345-1-m.felsch@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 05/17/2018 03:55 PM, Marco Felsch wrote:
> The ssm2305 is a simple Class-D audio amplifier. A application can
> turn on/off the device by a gpio. It's also possible to hardwire the
> shutdown pin.
> 
> Tested on a i.MX6 based custom board.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
