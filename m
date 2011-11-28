From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 2/2] ASoC: Convert tegra_spdif to use
 module_platform_driver()
Date: Mon, 28 Nov 2011 13:46:34 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174FDAF8F4@HQMAIL01.nvidia.com>
References: <1322477637.1939.3.camel@phoenix> <1322477703.1939.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C81B243BA
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 22:46:42 +0100 (CET)
In-Reply-To: <1322477703.1939.4.camel@phoenix>
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
To: Axel Lin <axel.lin@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Axel Lin wrote at Monday, November 28, 2011 3:55 AM:
> Use the module_platform_driver() macro which makes
> the code smaller and a bit simpler.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
