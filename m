From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: sn95031: Add support for reading
	mic bias
Date: Wed, 9 Feb 2011 15:06:06 +0000
Message-ID: <20110209150606.GF24042@opensource.wolfsonmicro.com>
References: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
	<1297242747-18632-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3990A24490
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 16:06:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297242747-18632-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 09, 2011 at 02:42:27PM +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> This patch adds support to read the mic bias voltage
> when a jack is inserted. It uses ADC to measure.

This looks OK.
