From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/1] ALSA: Fix limit of 8 PCM devices in
 SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE
Date: Tue, 29 Jul 2008 21:36:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0807292136000.7676@tm8103-a.perex-int.cz>
References: <1217349266.29863.40.camel@bri1004.bri.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FC8F248AF
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 21:36:43 +0200 (CEST)
In-Reply-To: <1217349266.29863.40.camel@bri1004.bri.st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pawel MOLL <pawel.moll@st.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 29 Jul 2008, Pawel MOLL wrote:

> ALSA: Fix limit of 8 PCM devices in SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE

Thanks. Applied to my GIT tree.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
