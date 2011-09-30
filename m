From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Use driver_data field
 of struct i2c_device_id to identify models
Date: Fri, 30 Sep 2011 13:56:48 +0100
Message-ID: <20110930125647.GL5366@opensource.wolfsonmicro.com>
References: <1317218208.8008.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17DF4103BB2
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 14:56:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317218208.8008.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Vladimir Barinov <vova.barinov@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 28, 2011 at 09:56:48PM +0800, Axel Lin wrote:
> Save model information in driver_data so we can simplify the implementation.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
