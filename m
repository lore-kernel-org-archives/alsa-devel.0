From: David Henningsson <david.henningsson@canonical.com>
Subject: Fwd: USB MIDI Specification Update Proposal
Date: Sun, 20 Jul 2014 20:52:34 +0200
Message-ID: <53CC0FF2.8000702@canonical.com>
References: <20140715234123.11232.qmail@vps-1011917-539.manage.myhosting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D51B626500C
 for <alsa-devel@alsa-project.org>; Sun, 20 Jul 2014 20:52:33 +0200 (CEST)
Received: from hd9483857.selulk5.dyn.perspektivbredband.net ([217.72.56.87]
 helo=[192.168.8.102])
 by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.henningsson@canonical.com>)
 id 1X8wDp-0001hi-CS
 for alsa-devel@alsa-project.org; Sun, 20 Jul 2014 18:52:33 +0000
In-Reply-To: <20140715234123.11232.qmail@vps-1011917-539.manage.myhosting.com>
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

Forwarding this in case anyone is interested in influencing this 
standard somehow, to make sure they don't do anything problematic for 
us...? Are we interested?

// David

-------- Original Message --------
Subject: 	USB MIDI Specification Update Proposal
Date: 	15 Jul 2014 19:41:23 -0400
From: 	MMA/IASIG Announcements <info@midi.org>
To: 	



July 15, 2014

Greetings,

The MIDI Manufacturers Association ("MMA") Technical Standards Board
("TSB") has formed a working group to update the USB Class Specification
for MIDI Devices.

The original version 1.0 specification was published in 1999 by the USB
Implementors Forum (USB-IF). It has been implemented in hundreds
(thousands?) of devices from many different manufacturers, and all of
the major operating systems include "class drivers" that allow MIDI
devices to connect by USB without the user needing to install a driver.

Meanwhile, the technology and the environment around MIDI and USB have
changed:

   * Processors are faster, and USB itself is faster
   * Many music devices are equipped with USB ports for MIDI, and some of
     those can operate at faster than MIDI-DIN speed (typically via
     custom USB drivers)
   * Popular mobile systems now also support MIDI via USB, but do not
     allow manufacturers to install custom drivers
   * Mobile has low power requirements

Given all of these factors, we think the USB-MIDI Specification could
benefit from an update. We do not propose a major overhaul or any change
of basic architecture, but rather a minor update that we expect to label
as a version 1.1. The update will be done in collaboration with the
USB-IF. Components of the proposed Version 1.1 Update that we plan to
discuss include:

   * Additional Device Attributes
   * Bandwidth Descriptors
   * Add Interrupt Mode
   * Transfer Non-MIDI Data / Meta Event
   * Product Identification (Logos)

We would like all commercial manufacturers of USB MIDI hardware and
software to join us in this effort. If you would like to comment, ask
questions, voice an opinion or suggestion, or simply have early access
to the specification, please join the MMA and subscribe to the working
group email mailing list.

Regards,

Mike Kent, WG Chair (Roland Corp.)
Tom White, President/CEO, MMA



------------------------------------------------------------------------

(C) 2014 MIDI Manufacturers Association Incorporated.
