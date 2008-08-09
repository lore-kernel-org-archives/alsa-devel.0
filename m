From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm8750: it's MONO1, not MONO
Date: Sat, 9 Aug 2008 18:12:03 +0100
Message-ID: <20080809171202.GA7621@sirena.org.uk>
References: <1218279928-16785-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D187F24C74
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Aug 2008 19:11:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218279928-16785-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 09, 2008 at 03:05:28PM +0400, Dmitry Baryshkov wrote:
> Since first commit wm8750 contained output named MONO, but
> all routes mentioned MONO1. Correct MONO to be MONO1.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
