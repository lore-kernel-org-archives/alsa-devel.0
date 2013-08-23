From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v11] ASoC: fsl: Add S/PDIF machine driver
Date: Fri, 23 Aug 2013 13:53:03 -0600
Message-ID: <5217BD9F.1080704@wwwdotorg.org>
References: <fac39ed91818630e03f81a5f0cf9ddde0e6a3c3a.1377244995.git.b42378@freescale.com>
 <5217B32C.5070300@wwwdotorg.org> <20130823191353.GK25263@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 235942615AE
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 21:53:08 +0200 (CEST)
In-Reply-To: <20130823191353.GK25263@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, tomasz.figa@gmail.com, rob.herring@calxeda.com, p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 08/23/2013 01:13 PM, Mark Brown wrote:
> On Fri, Aug 23, 2013 at 01:08:28PM -0600, Stephen Warren wrote:
>> On 08/23/2013 02:04 AM, Nicolin Chen wrote:
>>> This patch implements a device-tree-only machine driver for
>>> Freescale i.MX series Soc. It works with
>>> spdif_transmitter/spdif_receiver and fsl_spdif.c drivers.
> 
>> The binding looks reasonable to me now. Thanks.
> 
> Is that a Reviewed-by?

Sure, it can be,
Acked-by: Stephen Warren <swarren@nvidia.com>
