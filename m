From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs42l73: Make inv and format to be
	unsigned int
Date: Tue, 22 Nov 2011 13:02:58 +0000
Message-ID: <20111122130258.GB21029@opensource.wolfsonmicro.com>
References: <1321607782.8417.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E13D103A5B
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 14:03:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321607782.8417.2.camel@phoenix>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org, Georgi Vlaev <joe@nucleusys.com>, Liam Girdwood <lrg@ti.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 18, 2011 at 05:16:22PM +0800, Axel Lin wrote:
> Fix below smatch warning:

Applied, thanks.
