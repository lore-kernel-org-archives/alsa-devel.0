From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 08/13] Have the WM9712 driver
	self	register itself
Date: Thu, 14 May 2009 11:45:54 +0100
Message-ID: <20090514104554.GF28291@sirena.org.uk>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015916.28145.31979.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FBEC2442D
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 12:45:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090514015916.28145.31979.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 09:59:16PM -0400, Jon Smirl wrote:
> Have the WM9712 driver self register itself. This is needed to support device tree driver binding via the soc_of_simple code.
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

All the comments I made when you posted this earlier yesterday continue
to apply.
