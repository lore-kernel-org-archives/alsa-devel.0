From: Pengcheng Zou <pczou@redflag-linux.com>
Subject: Capturing of Samsung Q1 Ultra (ALC262) does not work
Date: Sat, 29 Sep 2007 20:14:09 +0800
Message-ID: <200709292014.09195.pczou@redflag-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from redflag-linux.com (mail.redflag-linux.com [219.237.229.196])
	by alsa0.perex.cz (Postfix) with SMTP id C0154243B8
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Sep 2007 14:16:58 +0200 (CEST)
Received: From pczou.redflag-linux.com[124.16.138.56] by
	smtp.redflag-linux.com with Red Flag Webmail Server id 17713
	for alsa-devel@alsa-project.org; Sat Sep 29 20:11:17 2007 +0800
Content-Disposition: inline
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

Hi,

capture function of the Samsung Q1 Ultra (using ALC262 codec) does not work. I 
tried the most recent ALSA build (alsa-driver-1.0.15rc3), the playback works 
well, however the recording does not work. 

Samsung Q1 (using AD1986A codec) has been supported already, wonder if there 
is any patches for Q1 Ultra?

please note Samsung released 2 types of UPMC, Q1 and Q1 Ultra. the Q1 ultra is 
the one I have:
  http://computers.pricegrabber.com/tablet-pcs/m/37616779/details/

TIA,
  -- Pengcheng
