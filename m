From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ALSA: msnd: Optimize / harden DSP and MIDI loops
Date: Fri, 8 Sep 2017 18:27:44 +0200
Message-ID: <20170908162744.GA31095@kroah.com>
References: <20170908160626.24771-1-gtertych@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170908160626.24771-1-gtertych@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii tertychnyi <gtertych@cisco.com>
Cc: tiwai@suse.de, xe-linux-external@cisco.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 08, 2017 at 09:06:25AM -0700, grygorii tertychnyi wrote:
> Hi Greg,
> 
> Could you please apply it for 4.4-stable.
> This fixes https://nvd.nist.gov/vuln/detail/CVE-2017-9985

Why just 4.4?  What about 4.12, 4.9, and any others?

thanks,

greg k-h
