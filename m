From: Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: ALSA SoC device tree bindings
Date: Wed, 23 Jun 2010 20:30:13 +0800
Message-ID: <201006232030.14138.jeremy.kerr@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi all,

>From some discussions at the previous Ubuntu Developer Summit, I've put up a 
page on the devicetree.org wiki with the ultimate goal of describing device 
tree bindings for ALSA System on Chip devices.

At this stage, we're just looking at how to structure device in the device 
tree. The bindings for specific devices will come as required (ie, as we add 
device tree support for them).

So - if you're interested in the ALSA and/or device tree areas, please take a 
look at the notes from UDS:

 http://devicetree.org/SoC_Audio

- if you have any comments or suggestions, please let me know, or add to the 
page (or the discussion for the page). I intend for this document to become a 
more formal specification, but we still have a way to go before that happens.

If you'd like an introduction to device trees, Grant has a good walkthrough-
style document at:

 http://devicetree.org/Device_Tree_Usage

Cheers,


Jeremy
