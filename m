From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Wrong variable returned on error
Date: Tue, 8 Dec 2009 12:56:39 +0000
Message-ID: <20091208125639.GA1844@rakim.wolfsonmicro.main>
References: <4B1D9F0E.4010009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC80024563
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 13:56:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B1D9F0E.4010009@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, javier.martin@vista-silicon.com, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 08, 2009 at 01:34:22AM +0100, Roel Kluin wrote:
> The wrong variable was returned in the case of an error
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Applied, thanks.
