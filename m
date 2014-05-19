From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: wm9713: correct mono out PGA
	sources
Date: Mon, 19 May 2014 17:26:59 +0100
Message-ID: <20140519162659.GS25203@opensource.wolfsonmicro.com>
References: <1400186759-24248-1-git-send-email-mreimer@sdgsystems.com>
 <1400515470-3474-1-git-send-email-mreimer@sdgsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24CD1260890
 for <Alsa-devel@alsa-project.org>; Mon, 19 May 2014 18:27:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1400515470-3474-1-git-send-email-mreimer@sdgsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Reimer <mreimer@sdgsystems.com>
Cc: Alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 19, 2014 at 09:04:30AM -0700, Matt Reimer wrote:
> The mono output PGA input only has four possible sources, so
> omit the rest.
> 
> Signed-off-by: Matt Reimer <mreimer@sdgsystems.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
