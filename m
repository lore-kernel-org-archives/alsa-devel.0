From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v12] ASoC: fsl: Add S/PDIF machine driver
Date: Thu, 29 Aug 2013 12:21:29 -0600
Message-ID: <521F9129.5010805@wwwdotorg.org>
References: <1377662686-31696-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 76A7F26557E
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 20:21:36 +0200 (CEST)
In-Reply-To: <1377662686-31696-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, s.hauer@pengutronix.de, tomasz.figa@gmail.com, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 08/27/2013 10:04 PM, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.

Sorry for the slow response. For the record, the binding,
Acked-by: Stephen Warren <swarren@nvidia.com>
