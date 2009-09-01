From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] new board driver to connect bfin-5xx
	with	ad1836 codec
Date: Tue, 1 Sep 2009 11:40:36 +0100
Message-ID: <20090901104036.GB18651@sirena.org.uk>
References: <1251780314-18707-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 200A124451
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 12:40:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1251780314-18707-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 01, 2009 at 12:45:14PM +0800, Barry Song wrote:

> As discussed, the patch uses the original TDM order without rewriting.
> For the match between TDM slot number and audio channel number, a new
> API need be added.

Applied, thanks.
