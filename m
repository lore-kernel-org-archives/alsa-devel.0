From: Geoffrey McRae <geoff@spacevs.com>
Subject: Re: ASUS Phoebus (CMI8888) HDA Support
Date: Wed, 4 Dec 2013 21:57:11 +1100
Message-ID: <20131204215711.68b52af6@sarah.home.spacevs.com>
References: <20131204213613.31b9a9c9@sarah.home.spacevs.com>
 <529F098C.3020208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.spacevs.com (mail1.spacevs.com [202.174.111.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B3D126262A
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 11:57:15 +0100 (CET)
In-Reply-To: <529F098C.3020208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 04 Dec 2013 11:53:00 +0100
Clemens Ladisch <clemens@ladisch.de> wrote:

> Geoffrey McRae wrote:
> > I enabled MMIO in my BIOS, which instantly fixed the missing RIRB
> > DMA data issue
> 
> What mainboard are you using, and what is the exact name of this BIOS
> option?
> 

Manufacturer: ASUSTeK COMPUTER INC.
Product Name: SABERTOOTH 990FX
Version: Rev 1.xx

The option is titled "MMIO", thats it. There is an additional option,
"MMIO Mode" which is set to "64MB".
