From: Steve Strobel <steve.strobel@link-comm.com>
Subject: Recommendations for 4-channel USB-connected audio
	interface
Date: Tue, 26 Jan 2010 13:51:12 -0700
Message-ID: <0McV8y-1NICye2Mzo-00Hqac@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 97E20244D1
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 21:51:47 +0100 (CET)
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

I am in need of an ALSA-compatible audio interface that will connect 
to a PC via USB and record/play four or more audio channels 
simultaneously.  Any recommendations (or warnings) about specific 
products or chipsets would be greatly appreciated.  High resolution 
and sample rates aren't necessary.

The rest of the story is that my company is working on a project 
using an embedded x86 computer to interface with four independent 
mono audio devices.  I will be responsible for the audio processing 
and want to make sure that we use an audio chipset for which an ALSA 
driver is already available.  I would also prefer that it interface 
via USB so I can easily test on my development PC, then move it to 
the embedded system.  We will eventually put the audio chipset on a 
custom PCB, so it is the audio chipset and driver that are my primary 
concerns, but a readily-available audio interface using the chipset 
would serve as a nice prototype.  Thanks for any suggestions.

Steve


---
Steve Strobel
Link Communications, Inc.
1035 Cerise Rd
Billings, MT 59101-7378
(406) 245-5002 ext 102
(406) 245-4889 (fax)
WWW: http://www.link-comm.com
MailTo:steve.strobel@link-comm.com
