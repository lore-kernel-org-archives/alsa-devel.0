From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] da7210: Fencepost error in reg cache read
Date: Wed, 21 Apr 2010 01:37:25 +0900
Message-ID: <20100420163724.GC30625@opensource.wolfsonmicro.com>
References: <1271253793-3539-1-git-send-email-ext-phil.2.carmody@nokia.com>
	<uy6gp9q0h.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4660824154
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Apr 2010 18:37:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <uy6gp9q0h.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Phil Carmody <ext-phil.2.carmody@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 15, 2010 at 03:41:13PM +0900, Kuninori Morimoto wrote:

> > An index equal to the array size may not be accessed.

> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, thanks.
