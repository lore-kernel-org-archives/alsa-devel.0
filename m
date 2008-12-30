From: Xuesong Yang <xsyang@pixelworks.com>
Subject: Is Asoc suitable for my device?
Date: Tue, 30 Dec 2008 17:25:22 +0800
Message-ID: <1230629122.21485.10.camel@star-sea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.pixelworks.com (smtp2.pixelworks.com [207.179.28.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F2E41037EC
	for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2008 10:25:47 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

hi all:
	I'm new to ALSA and still study it.
	My problem is I don't know if it suitable for my device use Asoc.
	In my platform, there is only a I2S bypass module, It has a route,
select one of the I2S source as input,(from HDMI or cpu data) delay the
data for some time and then output it to the backend.
	In theory, this device is very sample, but I find I can't get a easy
way to implement it in ALSA, I'm lost in ALSA.
	Any suggestion will be greatly appreciated.

Thanks.
