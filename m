From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ucm: Document PlaybackPCMIsDummy and
 CapturePCMIsDummy values
Date: Thu, 26 Jun 2014 13:49:17 +0100
Message-ID: <1403786957.2667.26.camel@loki>
References: <1403778625-4608-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3694F265007
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 14:49:44 +0200 (CEST)
In-Reply-To: <1403778625-4608-1-git-send-email-tanu.kaskinen@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Felipe Tonello <eu@felipetonello.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2014-06-26 at 13:30 +0300, Tanu Kaskinen wrote:
> At least PulseAudio needs special handling for dummy devices. To allow
> that to happen automatically, the UCM configuration should contain the
> information about which PCMs are dummy.

> Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
