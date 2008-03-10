From: rct@frus.com (Bob Tracy)
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 10 Mar 2008 17:22:11 -0500 (CDT)
Message-ID: <20080310222211.2A0BEDBA2@gherkin.frus.com>
References: <47D58C1F.7020805@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <47D58C1F.7020805@keyaccess.nl> "from Rene Herman at Mar 10, 2008
 08:29:35 pm"
Sender: linux-alpha-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Bob Tracy <rct@frus.com>, ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> Bob? How short are "short" wav files by the way?

The one I was using for testing is 50,272 bytes.  A slightly longer file
that exhibits "more exotic" looping behavior is 97,898 bytes (just a bit
over 6 seconds of audio).  I'll send you the shorter file under separate
cover.

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
