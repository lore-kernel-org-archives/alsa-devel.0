From: John Frankish <john.frankish@outlook.com>
Subject: Intel alsa sound request for Laptops
Date: Sat, 28 Jan 2017 12:46:57 +0000
Message-ID: <DBXPR04MB334548B939F29F8E6E24790F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from COL004-OMC1S6.hotmail.com (col004-omc1s6.hotmail.com
 [65.55.34.16]) by alsa0.perex.cz (Postfix) with ESMTP id 61F3D265AF3
 for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2017 13:47:00 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

For two or three kernel versions of alsa divers now, HDMI has been the default alsa device on my laptop (Dell Latitude E7240) - this does not make logical sense.

In the latest kernel version I use, 4.2.9, alsa sound will not work at all unless I load the i915 kernel driver - this does not make logical sense and means that I cannot use Xvesa.

Is it possible to make an alsa feature request for analogue sound to be the default alsa device on laptops and for alsa sound to work without the need to load the i915 kernel driver?

Regards
John

**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA Intel HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 0: ALC3226 Analog [ALC3226 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
