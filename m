From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 3/6] ASoC/ARM: Davinci: McASP: split asp
 header into platform and audio specific
Date: Mon, 27 Aug 2012 11:13:11 -0700
Message-ID: <20120827181311.GV4339@opensource.wolfsonmicro.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-4-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5FC9265EAD
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 20:13:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346074004-22172-4-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-user@lists.sourceforge.net, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 27, 2012 at 06:56:41PM +0530, Hebbar, Gururaja wrote:
> Davinci McASP header & driver are shared by few OMAP platforms (like
> TI81xx, AM335x). Splitting asp header into Davinci platform specific
> header and Audio specific header helps to share them across platforms.

Applied, thanks.
