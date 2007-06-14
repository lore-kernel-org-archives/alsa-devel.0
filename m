From: Walt Shekrota <wshekrota@optonline.net>
Subject: question about bluez using alsa and patches
Date: Thu, 14 Jun 2007 19:45:25 -0400
Message-ID: <200706141945.25383.wshekrota@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta2.srv.hcvlny.cv.net (mta2.srv.hcvlny.cv.net [167.206.4.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BDFF247D8
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 01:45:27 +0200 (CEST)
Received: from ool-45796d90.dyn.optonline.net
	(ool-45796d90.dyn.optonline.net [69.121.109.144]) by
	mta2.srv.hcvlny.cv.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTP id <0JJN00F4SGNQJEU0@mta2.srv.hcvlny.cv.net> for
	alsa-devel@alsa-project.org; Thu, 14 Jun 2007 19:45:26 -0400 (EDT)
Content-disposition: inline
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

I was told that when using the btsco(bluez) and/or plugs bluetooth headset 
software a patch is always required.
In the Gentoo community and perhaps everywhere it is suggested to use alsa 
compiled into your kernel.
As I go to new kernels frequently these folks (sco headset) seem to have no 
such forward support ie they have not worked on the patches yet for the newer 
kernels.
Am I wrong or at some point in time should this app not be weaned from using 
patches? Is it the fact they use sco that they have to patch? Is there not an 
alsa library they can program to instead.
I guess I don't understand the overall design so I can't see why this goes on 
forever.
I'm somewhat apprehensive about trusting others to continually modify my 
kernel.

Am I out in left field here? Can anyone explain why they must choose this 
path?

Thanks very much.
-Walt
