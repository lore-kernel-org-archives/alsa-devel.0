From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/3] WM8750: Convert to new API
Date: Mon, 5 Apr 2010 06:10:28 +0200
Message-ID: <201004050610.28610.marek.vasut@gmail.com>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f217.google.com (mail-fx0-f217.google.com
	[209.85.220.217])
	by alsa0.perex.cz (Postfix) with ESMTP id CBAA310381E
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Apr 2010 06:11:11 +0200 (CEST)
Received: by fxm9 with SMTP id 9so2970652fxm.4
	for <alsa-devel@alsa-project.org>; Sun, 04 Apr 2010 21:11:11 -0700 (PDT)
In-Reply-To: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
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
Cc: broonie@opensource.wolfsonmicro.com, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Dne Po 5. dubna 2010 06:00:03 Marek Vasut napsal(a):
> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Sorry, I'll send this one more time. I'll roll checkpatch fixes into this patch 
(as the lines checkpatch marked were moved anyway).
