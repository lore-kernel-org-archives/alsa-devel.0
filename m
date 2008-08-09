From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] wm8750: it's MONO1, not MONO
Date: Sat, 9 Aug 2008 15:05:18 +0400
Message-ID: <20080809110518.GB16696@doriath.ww600.siemens.net>
References: <1218279500-16583-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id E59AC24C34
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Aug 2008 13:05:23 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so711217fgg.44
	for <alsa-devel@alsa-project.org>; Sat, 09 Aug 2008 04:05:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218279500-16583-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 09, 2008 at 02:58:20PM +0400, Dmitry Baryshkov wrote:
> Since first commit wm8750 contained output named MONO, but
> all routes mentioned MONO1. Correct MONO to be MONO1.
> 
> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Oops... please ignore this version.

-- 
With best wishes
Dmitry
