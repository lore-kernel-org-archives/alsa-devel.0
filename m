From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: tlv320dac33: Start/stop sequence
 change
Date: Fri, 12 Mar 2010 08:10:32 +0000
Message-ID: <1268381432.3755.5.camel@odin>
References: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
	<1268317582-10284-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f173.google.com (mail-qy0-f173.google.com
	[209.85.221.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E28324363
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 09:10:36 +0100 (CET)
Received: by qyk4 with SMTP id 4so1012465qyk.2
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 00:10:36 -0800 (PST)
In-Reply-To: <1268317582-10284-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-11 at 16:26 +0200, Peter Ujfalusi wrote:
> To avoid race condition especially in FIFO modes the
> sequence for enabling and disabling the codec need to
> be changed.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
