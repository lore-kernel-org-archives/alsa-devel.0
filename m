From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 09/11] drivers: char: axd: add sysfs setup files
Date: Tue, 28 Oct 2014 14:38:29 +0000
Message-ID: <544FAA65.90904@imgtec.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com> <1414495589-8579-10-git-send-email-qais.yousef@imgtec.com> <20141028141154.GB18384@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141028141154.GB18384@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/28/2014 02:11 PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 28, 2014 at 11:26:27AM +0000, Qais Yousef wrote:
>> lots of AXD configuration is exposed through sysfs, these
>> files create all the necessary nodes to allow setting up AXD
> Yet you don't document that interface through the required
> Documentation/ABI/ files?  Why not?
>
Sorry I didn't realise I need to do that. I'll fix that in the next series.

Thanks,
Qais
