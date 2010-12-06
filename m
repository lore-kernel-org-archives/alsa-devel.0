From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: omap: Add hardware constraint
 for HDMI and ABE
Date: Mon, 6 Dec 2010 22:46:25 +0000
Message-ID: <20101206224624.GD2862@opensource.wolfsonmicro.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E80@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B63E910382A
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 23:46:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4C52E80@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 06, 2010 at 04:34:44PM -0600, Olaya, Margarita wrote:
> From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> 
> The Audio Backend needs a step size of 24 * 4, while HDMI requires a
> step size of 32 * 4 bits to align the audio buffer.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
